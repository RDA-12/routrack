# Routrack

Consistency is always a problem when starting new routine. We usually start strong but the excitement goes down over the time. One of the reason is because we can not have immediate result of the routine. Thats why routrack exists. It tracks your routine progress, makes you know how far you've come. It gives you immediate result you can see and how close you are to your goals.

## Technical

Routrack uses [Flutter](https://flutter.dev) as its UI toolkit with [material_ui](https://pub.dev/packages/material_ui) to creates beautiful and easy-to-use UI. It stores all users data on-device in [sqlite](https://www.sqlite.org/) database using [drift](https://pub.dev/packages/drift) to talk to it. To navigate users within the app, it uses [go_router](https://pub.dev/packages/go_router). Lastly, to manage app state, it uses [bloc](https://pub.dev/packages/bloc) and its Flutter companion [flutter_bloc](https://pub.dev/packages/flutter_bloc).

This app follow vertical slice and clean architecture principles. It divide its features into modules and each module have their own data, domain, and presentation layer. To easily manage dependencies, it uses [get_it](https://pub.dev/packages/get_it) with help of [injectable](https://pub.dev/packages/injectable) to generate GetIt codes.

The domain layer consists of entities, use cases, and repositories interface. Its where all business logic live. Its the core of the module. The pressentation layer will have the UI (pages and widgets) and also bloc to manage their state. Lastly, the data layer will have repository implementation of repository interface from domain layer. The repository uses [repository mixin](/lib/common/repository_mixin.dart). Since each module doesn't always need entire CRUD operations, by using mixin, it gives flexibility for each repository to have their own set of methods based on domain layer needs.

Each codes have their own test files in [test dir](./test) mirroring their implementation directoty. Specific to UI-test, its grouped by `Render` (testing how the Widget looks), `Interactions` (testing how the Widget interact, like button pressed), and  `Side Effects` (testing how the Widget reacts to something, like showing Snackbar when BLoC emits something).

## Features

- [x] Allows users to create new routine
- [ ] Allows users to upgrade their routine (e.g. from "do 1 push ups" to "do 5 push ups")
- [x] Allows users to scheduled their routines
- [ ] Allows users to tweak their routine's schedule
- [x] Allows users to track when they finished a routine
- [ ] Notify users to track their finished routines (e.g. at the end of the day)
- [ ] Allows users to includes routines into bigger goals (grouping list of routine in a goal)
- [ ] Shows users their routine progress