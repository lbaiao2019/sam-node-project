FROM public.ecr.aws/sam/build-nodejs14.x

COPY app.js parser.js package*.json ./

RUN npm install

CMD ["app.lambdaHandler"]
