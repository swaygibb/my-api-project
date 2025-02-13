# README

A project to show API integration and other things

## API Endpoints

### Authentication

All endpoints require an `Authorization` header with a static token.

### Shopify Integration

This api integrates with the following store: https://swaygibb.myshopify.com

### Shopify

#### List Products

- **URL:** `/shopify/products`
- **Method:** `GET`
- **Description:** Fetches products from the Shopify store and renders them as JSON.
- **Response:**
  - **Status 200 OK:**
    ```json
    [
      {
        "id": 123456789,
        "title": "Product 1",
        "body_html": "<strong>Good product!</strong>",
        "vendor": "Vendor 1",
        "product_type": "Type 1",
        "created_at": "2021-04-01T12:00:00-04:00",
        "handle": "product-1",
        "updated_at": "2021-04-01T12:00:00-04:00",
        "published_at": "2021-04-01T12:00:00-04:00",
        "template_suffix": "",
        "published_scope": "web",
        "tags": "",
        "admin_graphql_api_id": "gid://shopify/Product/123456789"
      },
      {
        "id": 987654321,
        "title": "Product 2",
        "body_html": "<strong>Another good product!</strong>",
        "vendor": "Vendor 2",
        "product_type": "Type 2",
        "created_at": "2021-04-01T12:00:00-04:00",
        "handle": "product-2",
        "updated_at": "2021-04-01T12:00:00-04:00",
        "published_at": "2021-04-01T12:00:00-04:00",
        "template_suffix": "",
        "published_scope": "web",
        "tags": "",
        "admin_graphql_api_id": "gid://shopify/Product/987654321"
      }
    ]
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

#### Sync Products

- **URL:** `/shopify/sync_products`
- **Method:** `POST`
- **Description:** Synchronizes products from the Shopify store and saves them to the database.
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "message": "Products synced successfully."
    }
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

#### Sync Inventory

- **URL:** `/shopify/sync_inventory`
- **Method:** `GET`
- **Description:** Synchronizes inventory levels from the Shopify store and saves them to the database.
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "message": "Inventory synced successfully."
    }
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

#### Sync Orders

- **URL:** `/shopify/sync_orders`
- **Method:** `GET`
- **Description:** Synchronizes orders from the Shopify store and saves them to the database.
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "message": "Orders synced successfully."
    }
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

#### Sync Customers

- **URL:** `/shopify/sync_customers`
- **Method:** `GET`
- **Description:** Synchronizes customers from the Shopify store and saves them to the database.
- **Response:**
  - **Status 200 OK:**
    ```json
    {
      "message": "Customers synced successfully."
    }
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

### Products

#### List Products

- **URL:** `/products`
- **Method:** `GET`
- **Description:** Fetches the list of products from the local database and renders them as JSON.
- **Response:**
  - **Status 200 OK:**
    ```json
    [
      {
        "id": 1,
        "shopify_id": 123456789,
        "title": "Product 1",
        "body_html": "<strong>Good product!</strong>",
        "vendor": "Vendor 1",
        "product_type": "Type 1",
        "inventory_quantity": 10,
        "created_at": "2021-04-01T12:00:00-04:00",
        "updated_at": "2021-04-01T12:00:00-04:00"
      },
      {
        "id": 2,
        "shopify_id": 987654321,
        "title": "Product 2",
        "body_html": "<strong>Another good product!</strong>",
        "vendor": "Vendor 2",
        "product_type": "Type 2",
        "inventory_quantity": 5,
        "created_at": "2021-04-01T12:00:00-04:00",
        "updated_at": "2021-04-01T12:00:00-04:00"
      }
    ]
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

### Customers

#### List Customers

- **URL:** `/customers`
- **Method:** `GET`
- **Description:** Fetches the list of customers from the local database and renders them as JSON.
- **Response:**
  - **Status 200 OK:**
    ```json
    [
      {
        "id": 1,
        "shopify_id": 123456789,
        "email": "customer1@example.com",
        "first_name": "John",
        "last_name": "Doe",
        "created_at": "2021-04-01T12:00:00-04:00",
        "updated_at": "2021-04-01T12:00:00-04:00"
      },
      {
        "id": 2,
        "shopify_id": 987654321,
        "email": "customer2@example.com",
        "first_name": "Jane",
        "last_name": "Doe",
        "created_at": "2021-04-01T12:00:00-04:00",
        "updated_at": "2021-04-01T12:00:00-04:00"
      }
    ]
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

### Orders

#### List Orders

- **URL:** `/orders`
- **Method:** `GET`
- **Description:** Fetches the list of orders from the local database and renders them as JSON.
- **Response:**
  - **Status 200 OK:**
    ```json
    [
      {
        "id": 1,
        "shopify_id": 123456789,
        "email": "customer1@example.com",
        "total_price": "100.00",
        "currency": "USD",
        "order_number": 1001,
        "created_at": "2021-04-01T12:00:00-04:00",
        "updated_at": "2021-04-01T12:00:00-04:00"
      },
      {
        "id": 2,
        "shopify_id": 987654321,
        "email": "customer2@example.com",
        "total_price": "200.00",
        "currency": "USD",
        "order_number": 1002,
        "created_at": "2021-04-01T12:00:00-04:00",
        "updated_at": "2021-04-01T12:00:00-04:00"
      }
    ]
    ```
  - **Status 500 Internal Server Error:**
    ```json
    {
      "error": "Error message"
    }
    ```

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

## Run ngrok

ngrok http 3000
