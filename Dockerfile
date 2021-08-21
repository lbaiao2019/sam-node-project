FROM public.ecr.aws/lambda/nodejs:14

COPY app.js parser.js package*.json  /var/task/

# Install NPM dependencies for function
RUN npm install

ENV S3_BUCKET=-leonardo-resize-image-bucket

CMD [ "app.lambdaHandler" ] 