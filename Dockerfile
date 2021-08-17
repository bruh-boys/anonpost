FROM bitwalker/alpine-elixir:1.12 as build
WORKDIR /app
COPY mix* ./
RUN mix deps.get
RUN mix deps.compile

FROM node:14.17-alpine as node
WORKDIR /app
RUN npm i -g typescript sass
COPY public/TS public/TS
COPY public/scss public/scss
COPY setup.sh .
RUN ./setup.sh

FROM build AS start
WORKDIR /app
COPY . .
RUN mix compile
CMD [ "mix", "run", "--no-halt" ]