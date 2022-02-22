# README

## Table

### UserTable

| columm | type |
| ------ | ------ |
| id | integer |
| name | srting |
| email | string |
| password | string |
| password_dogest | string |

### TaskTable

| columm | type |
| ------ | ------ |
| id | integer |
| user_id(FK) | integer |
| title | srting |
| content | text |
| deadline | datetime |
| priority | integer |
| status | string |

### ClassificationTable

| columm | type |
| ------ | ------ |
| id | integer |
| task_id(FK) | integer |
| label_id(FK) | integer |

### labelTable

| columm | type |
| ------ | ------ |
| id | integer |
| name | string |
