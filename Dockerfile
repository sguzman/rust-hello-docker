FROM liuchong/rustup:nightly-musl AS base
RUN mkdir app
WORKDIR ./app

COPY ./Cargo.toml ./Cargo.toml

ADD src src
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo build --package rust-hello-docker --bin hello --verbose --jobs 4 --all-features --release --target=x86_64-unknown-linux-musl --color always

FROM scratch
COPY --from=base /root/app/target/x86_64-unknown-linux-musl/release/hello /main

ENTRYPOINT ["/main"]
