FROM liuchong/rustup:nightly-musl AS base
RUN mkdir app
WORKDIR ./app

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN rustup target add x86_64-unknown-linux-musl

ADD src src

RUN cargo build --package rust-hello-docker --bin hello --verbose --jobs 2 --all-features --release --target=x86_64-unknown-linux-musl --color always

FROM scratch
COPY --from=base /root/app/target/x86_64-unknown-linux-musl/release/hello /main

ENTRYPOINT ["/main"]