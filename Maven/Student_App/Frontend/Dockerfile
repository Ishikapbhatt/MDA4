FROM node:16-slim
WORKDIR /app
COPY . /app
RUN npm install
RUN npm run build
RUN apt-get update && apt install -y apache2
RUN rm -rf /var/www/html/*
RUN cp -r /app/dist/* /var/www/html/
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]