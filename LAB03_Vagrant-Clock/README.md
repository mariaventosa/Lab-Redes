# Practica 03 
utilizando los archivos de la tarea e implementando vagrant se crearon dos servidores: uno con los recursos estaticos(client) y otro que proporciona el microservicio(server)

## SERVER 
vagrant ssh web
node app.js

## CLIENT
vagrant ssh clock
cd client
npm start

## to access from host:
on browser go to http://192.168.0.20:3000

