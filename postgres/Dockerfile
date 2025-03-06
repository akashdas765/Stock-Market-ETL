FROM postgres:13

# Set environment variables
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=1234
ENV POSTGRES_DB=stock_db

# Copy database dump into the container
COPY init.sql /docker-entrypoint-initdb.d/