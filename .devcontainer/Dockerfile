FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:18
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN sudo apt-get update && sudo apt-get install -y build-essential cmake clang git 
ENV PATH=/root/.cargo/bin:$PATH
RUN cargo install --git https://github.com/Sunscreen-tech/foundry --locked --profile local forge cast anvil

