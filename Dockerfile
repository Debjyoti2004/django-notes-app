FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install app dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000

# ✅ Set environment variables for MySQL (Adjust values as per your setup)
ENV DB_NAME=your_database_name
ENV DB_USER=your_database_user
ENV DB_PASSWORD=your_database_password
ENV DB_HOST=your_database_host
ENV DB_PORT=3306

# ✅ Run the migrations inside CMD to ensure the database is available
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]
