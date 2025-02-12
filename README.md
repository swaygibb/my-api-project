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

## Running Tests

To run the tests, use the following command:

```sh
bundle exec rspec
```
