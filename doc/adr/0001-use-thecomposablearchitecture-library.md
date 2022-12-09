# 1. Use TheComposableArchitecture Library

Date: 2022-12-04

## Status

Accepted

## Context

In order to split the view and the business logic we need to use a certain design pattern to fulfill this goal. In particular, the TheComposableArchitecture (TCA) library was build based on the design pattern Model View Intent (MVI). The library perfectly fits with the concept of SwiftUI (declarative programming) and it gives us the possibility to define a finite set of actions that can be taken by the user on the view or by any side effects. 

Should we use this library or use an older approach like MVVM or MVC.

## Decision

We will use the TheComposableArchitecture library from pointfreeco in our iOS application instead of implementing the older pattern ourselves.

## Consequences

- We are using the State-Of-The-Art technology in regards of SwiftUI.
- Unit testing becomes more easy and more focused.
- Consistend way of implementing the logic for a view.
- Developers who are not used to MVI or this new library have to learn and practise it.
- Breaking changes from the 3rd party library has to be adapted on the app when using always the major version.
