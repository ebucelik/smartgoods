//
//  HTTPClient.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 08.11.22.
//

import Foundation

class HTTPClient {

    // TODO: Remove the noRespone parameter when backend team returns valid decodable responses.
    /// A public generic method which will be called by all the views (or their Logic Core's)
    /// - Returns: The expected model which the http body response should have
    public func sendRequest<T: Codable>(call: Call, responseModel: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            sendRequest(call: call, responseModel: responseModel) { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: response)

                case let .failure(httpError):
                    continuation.resume(throwing: httpError)
                }
            }
        }
    }

    /// A private generic method which sends a network HTTP request to a specified URL
    /// - Parameters:
    ///   - call: An abstract protocol which delivers the information needed to create an URLRequest
    ///   - responseModel: The expected http body response should fit to this model
    ///   - completion: Will be called either when there is an failure or when the response was successful
    private func sendRequest<T: Codable>(call: Call, responseModel: T.Type, completion: @escaping (Result<T, HTTPError>) -> Void) {

        guard var urlComponents = URLComponents(string: call.httpUrl) else {
            completion(.failure(HTTPError.invalidURL))
            return
        }

        if let parameters = call.parameters {
            parameters.forEach { name, value in
                let urlQueryItem = URLQueryItem(name: name, value: value)

                urlComponents.queryItems?.append(urlQueryItem)
            }
        }

        guard let url = urlComponents.url else {
            completion(.failure(HTTPError.invalidURL))
            return
        }

        let urlRequest = createURLRequest(
            with: url,
            httpMethod: call.httpMethod,
            httpBody: call.httpBody
        )

        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if error != nil {
                completion(.failure(HTTPError.error(error?.localizedDescription ?? "")))
            } else {
                do {
                    guard let httpResponse = urlResponse as? HTTPURLResponse else {
                        completion(.failure(HTTPError.noResponse))
                        return
                    }

                    guard let data = data else { throw HTTPError.noResponse }

                    switch httpResponse.statusCode {
                    case 200...299:
                        guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else { completion(.failure(HTTPError.decode))
                            return
                        }

                        completion(.success(decodedResponse))

                    case 300...399:
                        completion(.failure(HTTPError.notModified))

                    case 401:
                        completion(.failure(HTTPError.unauthorized))

                    case 404:
                        completion(.failure(HTTPError.notFound))

                    case 405:
                        completion(.failure(HTTPError.methodNotAllowed))

                    case 500...599:
                        completion(.failure(HTTPError.serverError))

                    default:
                        completion(.failure(HTTPError.unexpectedStatusCode))
                    }
                } catch {
                    completion(.failure(HTTPError.error(error.localizedDescription)))
                }
            }
        }
        .resume()
    }

    /// Creates an URLRequest object
    /// - Parameters:
    ///   - url: URL of the ressource
    ///   - httpMethod: Typical HTTP method like GET, POST, PUT
    ///   - httpBody: The data that should be sent to the backend
    /// - Returns: URLRequest
    private func createURLRequest(with url: URL, httpMethod: HTTPMethod, httpBody: Encodable?) -> URLRequest {
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

        if let httpBody = httpBody {
            urlRequest.httpBody = try? JSONEncoder().encode(httpBody)
        }

        return urlRequest
    }
}
