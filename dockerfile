FROM ubuntu:16.04

# Update default packages
RUN apt-get -qq update

# Get Ubuntu packages
RUN apt-get install -y -q \
    build-essential \
    curl

# NOTE: no need to run update again at this point
# RUN apt-get update

# Get Rust; NOTE: using sh for better compatibility with other base images
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y

# Add .cargo/bin to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

COPY . .

# Check cargo is visible
RUN cargo build

ENTRYPOINT ["cargo", "run"]
