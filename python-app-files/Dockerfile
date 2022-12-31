# get python base image
FROM python:3.7-alpine

# make a code dir and cd into it
WORKDIR /code

# set the enterypoit file  to the flask project   app.py
ENV FLASK_APP=app.py

# set the Host
ENV FLASK_RUN_HOST=0.0.0.0

RUN apk add --no-cache gcc musl-dev linux-headers

#copy requirments file to the container
COPY requirements.txt requirements.txt

# install the requirements
RUN pip install -r requirements.txt

# Flask listen on port 5000
EXPOSE 5000

#copy project files
COPY . .

# run the flask project 
CMD ["flask", "run"]