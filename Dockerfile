#This Dockerfile is only for Practise/understand how to write a Dockerfile.

#Author of the file
LABEL author="Adnan <masattar0781@gmail.com>" \ 
    author2="AbdulSattar <masattar0782@gmail.com>" 

#Pull the base image
FROM Python:3.11-slim AS builder

#Set a working directory
WORKDIR /app

#Copy the code from host to container
COPY requirements.txt .

#Run the command to install the dependencies
RUN pip install -r requirements.txt --target /app/libraries

#Copy the code from host to container
COPY . .

######### I will take another IMAGE(distroless) with even lesser size (Minimal) ######
FROM gcr.io/distroless/python3-debian12 AS deployer

#Set a working directory
WORKDIR /app

#Copy the code from builder to deployer
COPY --from=builder /app/libraries /app/libraries

#Copy the code from host to container
COPY --from=builder /app .

ENV PYTHONNPATH="/app/libraries"
#Expose the port
EXPOSE 5000

#Set Executable
ENTRYPOINT ["Python"]

#Execute a command
CMD ["app.py"]
