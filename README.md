# NoodoeAssignment

### Case 1: Login API

#### 請依照文件的說明，執行使用者登入
http://docs.parseplatform.org/rest/guide/#logging-in

#### 測試環境的資料: API URL:
https://watch-master-staging.herokuapp.com/api/login API Params:

```curl
curl -X POST \
  https://watch-master-staging.herokuapp.com/api/login \
  -H 'Content-Type: application/json' \
  -H 'X-Parse-Application-Id: vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD' \
  -H 'X-Parse-REST-API-Key: ' \
  -d '{
    "username": "test2@qq.com",
    "password": "test1234qq"
}'
```

### Case 2: Updating users API

#### 請依照文件的說明，以及先前API得到的回應參參數，修改目前使用者的timezone資料。 http://docs.parseplatform.org/rest/guide/#updating-users

#### 測試環境的資料:
API URL:
https://watch-master-staging.herokuapp.com/api/users/{previous API's objectId} API Params:

```curl
curl -X PUT \
  https://watch-master-staging.herokuapp.com/api/users/WkuKfCAdGq \
  -H 'Content-Type: application/json' \
  -H 'X-Parse-Application-Id: vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD' \
  -H 'X-Parse-REST-API-Key: ' \
  -H 'X-Parse-Session-Token: r:a0ecc2ef28107277ee0d0672af2c19b2' \
  -d '{
    "timezone": 8
}'
```
