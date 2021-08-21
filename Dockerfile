FROM public.ecr.aws/lambda/nodejs:12

COPY app.js parser.js package*.json  /var/task/

# Install NPM dependencies for function
RUN npm install

ENV S3_BUCKET=-aircall-resize-image-bucket

CMD [ "app.lambdaHandler" ] 