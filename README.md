# README

A project to show API integration and other things

## API Endpoints

### Posts

#### List Posts

- **URL:** `/posts`
- **Method:** `GET`
- **Description:** Fetches all posts and renders them as JSON with pagination.
- **Parameters:**
  - `page` (optional): Page number for pagination (default: 1)
  - `per_page` (optional): Number of posts per page (default: 10)
- **Response:**
  - **Status 200 OK:**
    ```json
    [
      {
        "id": 1,
        "title": "Post 1",
        "body": "Body 1",
        "user_id": 1
      },
      {
        "id": 2,
        "title": "Post 2",
        "body": "Body 2",
        "user_id": 2
      }
    ]
    ```

#### Show Post

- **URL:** `/posts/:id`
- **Method:** `GET`
- **Description:** Fetches a single post by ID and renders it as JSON.
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "id": 1,
      "title": "Post 1",
      "body": "Body 1",
      "user_id": 1
    }
    ```
  - **Status 404 Not Found:**
    ```json
    {
      "error": "Post not found"
    }
    ```

#### Create Post

- **URL:** `/posts`
- **Method:** `POST`
- **Description:** Creates a new post and renders it as JSON.
- **Parameters:**
  - `title` (required): Title of the post
  - `body` (required): Body of the post
  - `user_id` (required): ID of the user creating the post
- **Response:**

  - **Status 201 Created:**
    ```json
    {
      "id": 3,
      "title": "Post 3",
      "body": "Body 3",
      "user_id": 1
    }
    ```
  - **Status 400 Bad Request:**

    ```json
    {
      "error": "Invalid parameters"
    }
    ```

#### Update Post

- **URL:** `/posts/:id`
- **Method:** `PUT`
- **Description:** Updates an existing post by ID and renders it as JSON.
- **Parameters:**
  - `title` (optional): New title of the post
  - `body` (optional): New body of the post
  - `user_id` (optional): ID of the user updating the post
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "id": 1,
      "title": "Updated Post 1",
      "body": "Updated Body 1",
      "user_id": 1
    }
    ```
  - **Status 400 Bad Request:**
    ```json
    {
      "error": "Invalid parameters"
    }
    ```
  - **Status 404 Not Found:**
    ```json
    {
      "error": "Post not found"
    }
    ```

#### Destroy Post

- **URL:** `/posts/:id`
- **Method:** `DELETE`
- **Description:** Deletes an existing post by ID.
- **Response:**

  - **Status 204 No Content:**
    ```json
    {}
    ```
  - **Status 404 Not Found:**

    ```json
    {
      "error": "Post not found"
    }
    ```

### Health

#### Health Check

- **URL:** `/check_health`
- **Method:** `GET`
- **Description:** Returns the health status of the application.
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "status": "ok",
      "database": "connected",
      "external_service": "reachable",
      "timestamp": "2025-02-12T17:38:43.432-06:00"
    }
    ```

### Sync Controller

#### Sync Posts

- **URL:** `/sync_posts`
- **Method:** `POST`
- **Description:** Synchronizes posts from an external service and renders a success message with a timestamp.
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "message": "Posts synced successfully.",
      "timestamp": "2025-02-12T17:38:43.432-06:00"
    }
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

## Running Tests

To run the tests, use the following command:

```sh
bundle exec rspec
```
