# novai
Simple Docker Deployment for the popular Anime AI drawer
** WARNING: Using this content might be illegal in your country or location. **

## Prerequisites for out-of-the-box execution (without rebuilding the modules and exchanging the transformer models)
- NVIDIA GPU with >35 GB Memory
- NVIDIA Driver == 515.xx (or greater) 

## Run
1. Get the model by executing:
```
curl -LO https://cloudflare-ipfs.com/ipfs/bafybeiccldswdd3wvg57jhclcq53lvsc6gizasiblwayvhlv6eq4wow7wu/animevae.pt 
curl -L https://cloudflare-ipfs.com/ipfs/bafybeibhlcqjgvjtc3ck2bcazae5yizaetm7y7nm5rux674gsxgd4l5uce/animefull-latest.tar.zst | zstdcat | tar xf -
```
2. Get the prebuild container 
```
docker pull rimurosu/novai:withpt
```

If you do not with to use the pre-built OpenAI Transformer model (which is frequently updated, so might need a refresh, and I don't really have any bandwidth to do so), please use this instead: 
```
docker pull rimurosu/novai:latest
```
This will trigger the download when you execute the container. 

3. Run the container with the following command: 
```
docker run --gpus all -v $PWD/animevae.pt:/workspace/animevae.pt -v $PWD/animefull-latest:/workspace/animefull-latest -p 80:80 -p 8080:8080 rimurosu/novai:withpt
```
assuming that your downloaded models are located in the current directory with the name `animefull-latest` and `animevae.pt`. 

4. Use local browser and navigate to `http://127.0.0.1:8080`

5. In the website, use the backend address `127.0.0.1:80`

6. Enjoy

## Mass generation
If you want to generate a large amount of content please use the `generate.py` script. 
By default it will generate 1000 images of the same kind. 

## Credits
This project is based on the frontend from [novelai-simple](https://github.com/nidbCN/novelai-sample) by [nidbCN](https://github.com/nidbCN).
Container is based on NVIDIA NGC Public Container
