# Users

`render.raw.users` — 1 operation on `/users`.

| Method | | |
| --- | --- | --- |
| [`getUser`](#getuser) | `GET /users` | Get the authenticated user |

---

## getUser

**Get the authenticated user**

Retrieve the user associated with the provided API key.


```dart
Future<User> getUser()
```

`GET /users`

Takes no parameters.

Returns `User`.

| Field | Type | |
| --- | --- | --- |
| `email` | `String` |  |
| `name` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/get-user)

