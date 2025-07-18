# Import the FastAPI class from the fastapi library
from fastapi import FastAPI

# Create an instance of the FastAPI application
# This is the main object that provides all the functionality for your API.
app = FastAPI()

# Define a root endpoint using the @app.get() decorator.
# This decorator registers the function below it to handle GET requests
# to the specified path ("/").
@app.get("/")
async def read_root():
    """
    This asynchronous function handles GET requests to the root path ("/").
    It returns a simple JSON dictionary.
    The 'async' keyword makes it an asynchronous function, which is
    recommended for FastAPI for better performance, especially with I/O-bound tasks.
    """
    return {"message": "Hello World from FastAPI! Blue"}

# To run this application:
# 1. Save the code above as a Python file (e.g., main.py).
# 2. Make sure you have FastAPI and Uvicorn installed:
#    pip install fastapi uvicorn
# 3. Run the application from your terminal using Uvicorn:
#    uvicorn main:app --reload
#
# Once running, you can access your API in your web browser at:
# http://127.0.0.1:8000/
# You can also access the interactive API documentation (Swagger UI) at:
# http://127.0.0.1:8000/docs
# Or the alternative ReDoc documentation at:
# http://127.0.0.1:8000/redoc
