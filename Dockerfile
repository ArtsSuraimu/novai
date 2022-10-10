FROM nvcr.io/nvidia/pytorch:22.09-py3

RUN apt-get -qy update 
RUN apt-get -qy install zstd

RUN curl -L https://cloudflare-ipfs.com/ipfs/bafybeiagafvge2siezdmkhiwrlj7obtjy6i3x7rbbaovw3247uk6xcob2e/sd-private.tar.zst | zstdcat | tar xf -
RUN curl -L https://cloudflare-ipfs.com/ipfs/bafybeidcibcsoso3ez453fnajqj7x5forntk6rkglvpp33h5pzsopdvwgq/modules.tar.zst | zstdcat | tar xf -


RUN pip install dotmap icecream sentry-sdk numpy fastapi "uvicorn[standard]" gunicorn omegaconf transformers einops \
    pytorch_lightning simplejpeg min-dalle faiss-cpu sentence_transformers
RUN pip install -e "git+https://github.com/CompVis/taming-transformers.git#egg=taming-transformers"

RUN pip install -e sd-private/hydra-node-http/stable-diffusion-private/
RUN pip install https://github.com/NovelAI/k-diffusion-multigen/archive/457560c53c344b16cf3dda5eb0ba44d83e0b7c46.zip 
RUN pip install https://cloudflare-ipfs.com/ipfs/bafybeie5l2n7lyohudu2cu77uiv3pwjx6pwokaqszte7eg6qaz2hndfeiu/basedformer.tar 

RUN pip install -U --pre triton xformers==0.0.12

RUN curl -Ls https://github.com/ekzhang/bore/releases/download/v0.4.0/bore-v0.4.0-x86_64-unknown-linux-musl.tar.gz | tar zx -C /usr/bin

RUN curl https://cloudflare-ipfs.com/ipfs/bafybeiaza43ds5d2ifjcyb6vpoxekh5tq7wrsxgsyrxbqevkmn46ausiz4/hydra.tar | tar x -C sd-private/hydra-node-http/hydra_node


RUN python -m pip install git+https://github.com/pybpc/walrus
RUN python -m walrus sd-private/hydra-node-http

#cd sd-private/hydra-node-http/

ENV DTYPE=float16
ENV AMP=1
ENV MODEL=stable-diffusion
ENV DEV=True
ENV MODEL_PATH=/workspace/animefull-latest
ENV MODULE_PATH=/workspace/modules/modules
ENV TRANSFORMERS_CACHE=/workspace/transformer_cache
ENV SENTRY_URL=
ENV ENABLE_EMA=1
ENV VAE_PATH=/workspace/animevae.pt
ENV BASEDFORMER=1
ENV PENULTIMATE=1


RUN git clone https://github.com/nidbCN/novelai-sample

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


RUN cd novelai-sample 
RUN curl -Lo vue.config.js https://cloudflare-ipfs.com/ipfs/bafybeiaendc4ugufj6t6sgvoht27h3p46e4go4azn5igzds5l2xzjbl7g4/vue.config.js 

ENV NVM_DIR /usr/local/nvm
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
RUN source /root/.bashrc && nvm install --lts
SHELL ["/bin/bash", "--login", "-i", "-c"]
WORKDIR /workspace/novelai-sample

RUN npm i 

WORKDIR /workspace

ADD start.sh /workspace
RUN mkdir  /workspace/transformer_cache
ADD transformer_cache /workspace/transformer_cache
CMD /workspace/start.sh
