# GDTF Share API

## Introduction

The GDTF Share provides a REST Web API that allows users to login, view the existing fixtures, and download any revisions without needing a web browser to access the GDTF Share website. 

This API provides three functions:
- Login: Using the username and password from the account registered at the GDTF Share.
- Get List: Revision listing with a simple versioning hash.
- Download: Download file using the Revision ID.

The indivitual functions are described in the chapter [Functions](#functions).


## Use cases 

This API is provided for the convenience of users who want to integrate the GDTF Share into their own applications, but it is not intended to be used as a replacement for the GDTF Share website. It aims to provide a simple way to access the GDTF Share functionality for the following use cases:

- Application developers who do not want to include a full web browser in their products, but prefer to implement the functionality of the GDTF Share directly.
- Console and application designers who want to design their own user interface, for example, for login, listing or download.
- Integration of the GDTF database into the fixture type patching process.


## Requirements

### 1. GDTF Share User Account

A GDTF Share account is required for users to access the functionality provided by the API. If the user is not registered, they should be directed to https://gdtf-share.com/signup to create a free account.

The GDTF Share and the API are not accessible to users who do not have a registered account. If you are not the end user, you should direct your customers who wish to use this functionality to the GDTF Share website to create an account.


### 2. Software

The API requires the usage of any client that supports Web APIs, for example, CURL, which supports a wide variety of operating systems and platforms. To learn more about Web APIs, please visit: https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Client-side_web_APIs/Introduction


### 3. Cookies

A session cookie is required to ensure each request is authenticated. If the cookie is not used between requests, the user will not have permissions to access any functions. This cookie has a timeout of 2 hours. If the cookie is not used within this time, the user will need to login again.

Examples of how to use a cookie file with CURL are provided in the sample requests. If you wish to know more about cookies, please visit: https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies


## Functions

## Login

This function allows the user login by username and password.

<table>
    <tr>
        <th>Method</th>
        <th>Content type</th>
        <th>Path</th>
    </tr>
    <tr>
        <td>POST</td>
        <td>application/json</td>
        <td>https://gdtf-share.com/apis/public/login.php</td>
    </tr>
</table>


### Parameters

<table>
    <tr>
        <th>Parameter</th>
        <th>Required/optional</th>
        <th>Description</th>
        <th>Type</th>
    </tr>
    <tr>
        <td>user</td>
        <td>Required</td>
        <td>Username as registered in the GDTF Share.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>password</td>
        <td>Required</td>
        <td>Password of the user account.</td>
        <td>String</td>
    </tr>
</table>


### Response

<table>
    <tr>
        <th>Content type</th>
        <th>HTTP Status codes</th>
    </tr>
    <tr>
        <td>application/json</td>
        <td>200, 400, 401</td>
    </tr>
</table>


### Sample request

```
curl    -c session.txt -L -X POST https://gdtf-share.com/apis/public/login.php
        -H 'Content-Type: application/json'
        -d '{"user":"Real User 42", "password":"123SafePassw0rd456"}'
```


### Sample response

__On success:__ HTTP Code 200
```
{"result":true, "notice":"Welcome! Why did the coffee file a police report?  It got mugged."}
```

__On error:__ HTTP Code 401
```
{"result":false, "error":"No valid user or password provided."}
```


## Get List

This function allows a user to get the list of revisions.

<table>
    <tr>
        <th>Method</th>
        <th>Path</th>
    </tr>
    <tr>
        <td>GET</td>
        <td>https://gdtf-share.com/apis/public/getList.php</td>
    </tr>
</table>


### Parameters
This function does not require any parameters.


### Response

<table>
    <tr>
        <th>Content type</th>
        <th>HTTP Status codes</th>
    </tr>
    <tr>
        <td>application/json</td>
        <td>200, 400, 401, 500</td>
    </tr>
</table>


### Sample request

```
curl    -b session.txt https://gdtf-share.com/apis/public/getList.php
```


### Sample response

__On success:__ HTTP Code 200
```
{“result”:true, “timestamp”:1672531200, “list”:[<array>]}
```

__On error:__ HTTP Code 401
```
{“result”:false, ”error”:"Unauthorized."}
```

The “list” in the returned result is an array, and each array element has the following format:
```
{
    “rid”: 12345
    “fixture”: “Example Fixture”
    “manufacturer”: “Example Manufacturer"
    “revision”: ”Example revision"
    “creationDate”: “1570494396”
    “lastModified”:  ”1570494396”,
    “uploader”: “Manuf.”
    “rating: “4.1”
    “version: “1.0”
    “creator”: “Real User 42”
    “uuid”: “AAAAAAAA-3545-4C7C-ACA2-AAAAAAAAAAAA"
    “filesize”: 4809117
    “modes”: array
    [
        {“0”: array [2] {name: “mode1”, dmxfootprint: 49 }}
        {…}
    ]
}
```

### Response definitions

The following table describes each item in the response.

<table>
    <tr>
        <th>Response item</th>
        <th>Description</th>
        <th>Data type</th>
    </tr>
    <tr>
        <td>rid</td>
        <td>Revision ID.</td>
        <td>Integer</td>
    </tr>
    <tr>
        <td>fixture</td>
        <td>Fixture name.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>manufacturer</td>
        <td>Manufacturer name.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>revision</td>
        <td>Revision name.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>creationDate</td>
        <td>Creation date of the revision in UNIX timestamp format.</td>
        <td>Long</td>
    </tr>
    <tr>
        <td>lastModified</td>
        <td>Last modification date of the revision in UNIX timestamp format.</td>
        <td>Long</td>
    </tr>
    <tr>
        <td>uploader</td>
        <td>Uploader type: "Manuf." if the file was uploaded by a manufacturer, "User" if it was uploaded by a user.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>rating</td>
        <td>Rating of the revision, from 0 to 5.</td>
        <td>Float</td>
    </tr>
    <tr>
        <td>version</td>
        <td>GDTF version of the revision.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>creator</td>
        <td>Username of the original file uploader.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>uuid</td>
        <td>Unique ID of the fixture type. Each fixture has a unique ID that does not change across multiple revisions.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>filesize</td>
        <td>File size in bytes.</td>
        <td>Long</td>
    </tr>
    <tr>
        <td>modes</td>
        <td>Array with the modes, each item contains the Mode name and the DMX footprint.</td>
        <td>Array</td>
    </tr>
</table>

Each entry in the modes array contains the following items:
<table>
    <tr>
        <th>Item</th>
        <th>Description</th>
        <th>Data type</th>
    </tr>
    <tr>
        <td>name</td>
        <td>Mode name.</td>
        <td>String</td>
    </tr>
    <tr>
        <td>dmxfootprint</td>
        <td>DMX footprint of the mode.</td>
        <td>Integer</td>
    </tr>
</table>



## File download

This function allows the download of a single file.

<table>
    <tr>
        <th>Method</th>
        <th>Path</th>
    </tr>
    <tr>
        <td>GET</td>
        <td>https://gdtf-share.com/apis/public/downloadFile.php</td>
    </tr>
</table>


### Parameters

<table>
    <tr>
        <th>Parameter</th>
        <th>Required/optional</th>
        <th>Description</th>
        <th>Type</th>
    </tr>
    <tr>
        <td>rid</td>
        <td>Required</td>
        <td>Revision ID as provided in the Get List function.</td>
        <td>Integer</td>
    </tr>
</table>


### Response

For a successful download, the file is returned as a binary stream. For an error, a JSON object is returned. The HTTP status code can be used to determine if the download was successful or not, and the JSON response contains the relevant error message.

<table>
    <tr>
        <th>Content type</th>
        <th>HTTP Status codes</th>
    </tr>
    <tr>
        <td>application/octet-stream or application/json</td>
        <td>200, 400, 401, 500</td>
    </tr>
</table>


## Sample request

```
curl    -b session.txt https://gdtf-share.com/apis/public/downloadFile.php?rid=12345
        --output file.gdtf
```


## Sample response

__On success:__ HTTP Code 200

File is downloaded to "file.gdtf".


__On error:__ HTTP Code 404
```
{“result”:false, ”error”:"File does not exist."}
```

