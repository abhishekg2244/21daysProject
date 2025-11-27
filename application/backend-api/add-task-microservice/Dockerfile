# # # Use the official Python image as the base image
# # FROM python:3.9

# # # Set the working directory in the container
# # WORKDIR /app

# # # Copy the application files into the container
# # COPY . .

# # # Install necessary packages
# # RUN apt-get update && apt-get install -y unixodbc unixodbc-dev
# # RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# # RUN curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list
# # RUN apt-get update
# # RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

# # RUN pip install -r requirements.txt

# # # Start the FastAPI application
# # CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
# # #CMD uvicorn app:app --host 0.0.0.0 --port 8000

# # Use the official Python image as the base image
# FROM python:3.9

# # Set the working directory in the container
# WORKDIR /app

# # Copy application files
# COPY . .

# # Install necessary packages including curl and gnupg
# RUN apt-get update && apt-get install -y \
#     curl \
#     gnupg \
#     unixodbc \
#     unixodbc-dev

# # Add Microsoft package signing key
# RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft.gpg

# # Add Microsoft SQL repository
# RUN echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/10/prod stable main" \
#     > /etc/apt/sources.list.d/mssql-release.list

# # Update and install msodbcsql17
# RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

# # Install Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Start the FastAPI application
# CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
FROM python:3.9

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unixodbc \
    unixodbc-dev

RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" \
    > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
