# KeyValue

`render.raw.keyValue` — 8 operations on `/key-value`.

| Method | | |
| --- | --- | --- |
| [`createKeyValue`](#createkeyvalue) | `POST /key-value` | Create Key Value instance |
| [`deleteKeyValue`](#deletekeyvalue) | `DELETE /key-value/{redisId}` | Delete Key Value instance |
| [`listKeyValue`](#listkeyvalue) | `GET /key-value` | List Key Value instances |
| [`resumeKeyValue`](#resumekeyvalue) | `POST /key-value/{redisId}/resume` | Resume Key Value instance |
| [`retrieveKeyValue`](#retrievekeyvalue) | `GET /key-value/{redisId}` | Retrieve Key Value instance |
| [`retrieveKeyValueConnectionInfo`](#retrievekeyvalueconnectioninfo) | `GET /key-value/{redisId}/connection-info` | Retrieve Key Value connection info |
| [`suspendKeyValue`](#suspendkeyvalue) | `POST /key-value/{redisId}/suspend` | Suspend Key Value instance |
| [`updateKeyValue`](#updatekeyvalue) | `PATCH /key-value/{redisId}` | Update Key Value instance |

---

## createKeyValue

**Create Key Value instance**

Create a new Key Value instance.


```dart
Future<KeyValueDetail> createKeyValue({required KeyValuePostinput body})
```

`POST /key-value`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `body` | `KeyValuePostinput` | body | yes |  |

Returns `KeyValueDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the Key Value instance |
| `createdAt` | `DateTime` | The creation time of the Key Value instance |
| `updatedAt` | `DateTime` | The last updated time of the Key Value instance |
| `status` | `DatabaseStatus` |  |
| `region` | `Region` | Defaults to "oregon" |
| `plan` | `KeyValuePlan` |  |
| `name` | `String` | The name of the Key Value instance |
| `owner` | `Owner` |  |
| `options` | `KeyValueOptions` | Options for a Key Value instance |
| `ipAllowList` | `List<CidrBlockAndDescription>` | The IP allow list for the Key Value instance |
| `environmentId` | `String?` | The ID of the environment the Key Value instance is associated with |
| `version` | `String` | The version of Key Value |
| `maintenance` | `KeyValueDetailMaintenance?` |  |

[Render documentation](https://api-docs.render.com/reference/create-key-value)

## deleteKeyValue

**Delete Key Value instance**

Delete a Key Value instance by ID.


```dart
Future<void> deleteKeyValue({required String redisId})
```

`DELETE /key-value/{redisId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/delete-key-value)

## listKeyValue

**List Key Value instances**

List Key Value instances matching the provided filters. If no filters are provided, all Key Value instances are returned.


```dart
Future<List<KeyValueWithCursor>> listKeyValue({List<String>? name, List<String>? region, String? createdBefore, String? createdAfter, String? updatedBefore, String? updatedAfter, List<String>? ownerId, List<String>? environmentId, String? cursor, int? limit})
```

`GET /key-value`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `name` | `List<String>` | query | no | Filter by name |
| `region` | `List<String>` | query | no | Filter by resource region |
| `createdBefore` | `String` | query | no | Filter for resources created before a certain time (specified as an ISO 8601 timestamp) |
| `createdAfter` | `String` | query | no | Filter for resources created after a certain time (specified as an ISO 8601 timestamp) |
| `updatedBefore` | `String` | query | no | Filter for resources updated before a certain time (specified as an ISO 8601 timestamp) |
| `updatedAfter` | `String` | query | no | Filter for resources updated after a certain time (specified as an ISO 8601 timestamp) |
| `ownerId` | `List<String>` | query | no | The ID of the workspaces to return resources for |
| `environmentId` | `List<String>` | query | no | Filter for resources that belong to an environment |
| `cursor` | `String` | query | no | The position in the result list to start from when fetching paginated results. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |
| `limit` | `int` | query | no | The maximum number of items to return. For details, see [Pagination](https://api-docs.render.com/reference/pagination). |

Returns `List<KeyValueWithCursor>` — each element carries:

| Field | Type | |
| --- | --- | --- |
| `keyValue` | `KeyValue` | A Key Value instance |
| `cursor` | `String` |  |

[Render documentation](https://api-docs.render.com/reference/list-key-value)

## resumeKeyValue

**Resume Key Value instance**

Resume a Key Value instance by ID.


```dart
Future<void> resumeKeyValue({required String redisId})
```

`POST /key-value/{redisId}/resume`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/resume-key-value)

## retrieveKeyValue

**Retrieve Key Value instance**

Retrieve a Key Value instance by ID.


```dart
Future<KeyValueDetail> retrieveKeyValue({required String redisId})
```

`GET /key-value/{redisId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `KeyValueDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the Key Value instance |
| `createdAt` | `DateTime` | The creation time of the Key Value instance |
| `updatedAt` | `DateTime` | The last updated time of the Key Value instance |
| `status` | `DatabaseStatus` |  |
| `region` | `Region` | Defaults to "oregon" |
| `plan` | `KeyValuePlan` |  |
| `name` | `String` | The name of the Key Value instance |
| `owner` | `Owner` |  |
| `options` | `KeyValueOptions` | Options for a Key Value instance |
| `ipAllowList` | `List<CidrBlockAndDescription>` | The IP allow list for the Key Value instance |
| `environmentId` | `String?` | The ID of the environment the Key Value instance is associated with |
| `version` | `String` | The version of Key Value |
| `maintenance` | `KeyValueDetailMaintenance?` |  |

[Render documentation](https://api-docs.render.com/reference/retrieve-key-value)

## retrieveKeyValueConnectionInfo

**Retrieve Key Value connection info**

Retrieve connection info for a Key Value instance by ID. Connection info includes sensitive information.


```dart
Future<KeyValueConnectionInfo> retrieveKeyValueConnectionInfo({required String redisId})
```

`GET /key-value/{redisId}/connection-info`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `KeyValueConnectionInfo`.

| Field | Type | |
| --- | --- | --- |
| `internalConnectionString` | `String` | The connection string to use from within Render |
| `externalConnectionString` | `String` | The connection string to use from outside Render |
| `cliCommand` | `String` | The CLI (redis-cli or valkey-cli) command to connect to the Key Value instance |

[Render documentation](https://api-docs.render.com/reference/retrieve-key-value-connection-info)

## suspendKeyValue

**Suspend Key Value instance**

Suspend a Key Value instance by ID.


```dart
Future<void> suspendKeyValue({required String redisId})
```

`POST /key-value/{redisId}/suspend`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |

Returns `void`.

[Render documentation](https://api-docs.render.com/reference/suspend-key-value)

## updateKeyValue

**Update Key Value instance**

Update a Key Value instance by ID. Note that changing your plan, max memory policy, or persistence mode will restart your Key Value instance.


```dart
Future<KeyValueDetail> updateKeyValue({required String redisId, required KeyValuePatchinput body})
```

`PATCH /key-value/{redisId}`

| Parameter | Type | In | Required | |
| --- | --- | --- | --- | --- |
| `redisId` | `String` | path | yes |  |
| `body` | `KeyValuePatchinput` | body | yes |  |

Returns `KeyValueDetail`.

| Field | Type | |
| --- | --- | --- |
| `id` | `String` | The ID of the Key Value instance |
| `createdAt` | `DateTime` | The creation time of the Key Value instance |
| `updatedAt` | `DateTime` | The last updated time of the Key Value instance |
| `status` | `DatabaseStatus` |  |
| `region` | `Region` | Defaults to "oregon" |
| `plan` | `KeyValuePlan` |  |
| `name` | `String` | The name of the Key Value instance |
| `owner` | `Owner` |  |
| `options` | `KeyValueOptions` | Options for a Key Value instance |
| `ipAllowList` | `List<CidrBlockAndDescription>` | The IP allow list for the Key Value instance |
| `environmentId` | `String?` | The ID of the environment the Key Value instance is associated with |
| `version` | `String` | The version of Key Value |
| `maintenance` | `KeyValueDetailMaintenance?` |  |

[Render documentation](https://api-docs.render.com/reference/update-key-value)

