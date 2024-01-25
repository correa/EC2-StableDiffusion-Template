
# disable the restart dialogue and install several packages
sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
sudo apt-get update && apt-get upgrade -y
sudo apt install wget git git-lfs zip unzip rsync ffmpeg wget python3 python3-pip python3-venv python3-tk build-essential net-tools -y --no-install-recommends

# Install NVidia
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" -y
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub -y
sudo apt update
sudo apt install cuda -y
sudo apt autoremove -y

base_path="/home/ubuntu"

cd $base_path
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
git clone https://github.com/d8ahazard/sd_dreambooth_extension.git stable-diffusion-webui/extensions/sd_dreambooth_extension 
git clone --depth=1 https://github.com/deforum-art/sd-webui-deforum.git stable-diffusion-webui/extensions/deforum
git clone --depth=1 https://github.com/Mikubill/sd-webui-controlnet.git stable-diffusion-webui/extensions/sd-webui-controlnet
git clone --depth=1 https://github.com/ashleykleynhans/a1111-sd-webui-locon.git stable-diffusion-webui/extensions/a1111-sd-webui-locon
git clone --depth=1 https://github.com/Gourieff/sd-webui-reactor.git stable-diffusion-webui/extensions/sd-webui-reactor
git clone --depth=1 https://github.com/zanllp/sd-webui-infinite-image-browsing.git stable-diffusion-webui/extensions/infinite-image-browsing
git clone --depth=1 https://github.com/Uminosachi/sd-webui-inpaint-anything.git stable-diffusion-webui/extensions/inpaint-anything
git clone --depth=1 https://github.com/Bing-su/adetailer.git stable-diffusion-webui/extensions/adetailer
git clone --depth=1 https://github.com/civitai/sd_civitai_extension.git stable-diffusion-webui/extensions/sd_civitai_extension
git clone --depth=1 https://github.com/BlafKing/sd-civitai-browser-plus.git stable-diffusion-webui/extensions/sd-civitai-browser-plus

python3 -m venv --system-site-packages $base_path/stable-diffusion-webui/venv && \
    source $base_path/stable-diffusion-webui/venv/bin/activate && \
    find $base_path/stable-diffusion-webui -type f -name 'requirements.txt' -execdir pip3 install -r {} \;

    pip3 install -r stable-diffusion-webui/extensions/deforum/requirements.txt
    pip3 install -r stable-diffusion-webui/extensions/sd-webui-controlnet/requirements.txt
    pip3 install -r stable-diffusion-webui/extensions/sd-webui-reactor/requirements.txt
    pip3 install -r stable-diffusion-webui/extensions/sd-webui-reactor/requirements.txt
    pip3 install onnxruntime-gpu insightface
    pip3 install -r stable-diffusion-webui/extensions/infinite-image-browsing/requirements.txt
    python3 stable-diffusion-webui/extensions/adetailer/install.py
    pip3 install -r stable-diffusion-webui/extensions/sd_civitai_extension/requirements.txt
    pip3 install -r stable-diffusion-webui/extensions/sd_dreambooth_extension/requirements.txt
    

    # dependecies inpaint anything extension
    pip3 install segment_anything lama_cleaner 
    pip3 install send2trash ZipUnicode fake-useragent
    
    pip3 install torch torchvision torchaudio xformers

deactivate

wget -P stable-diffusion-webui/models/insightface https://github.com/facefusion/facefusion-assets/releases/download/models/inswapper_128.onnx
echo "CUDA" > stable-diffusion-webui/extensions/sd-webui-reactor/last_device.txt

wget https://raw.githubusercontent.com/Douleb/SDXL-750-Styles-GPT4-/main/styles.csv -O stable-diffusion-webui/styles.csv

# Download models
wget -P stable-diffusion-webui/models/Stable-diffusion https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors &
wget -P stable-diffusion-webui/models/Stable-diffusion https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors &
wget -P stable-diffusion-webui/models/Stable-diffusion https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors &
wget -P stable-diffusion-webui/models/Stable-diffusion https://huggingface.co/dreamlike-art/dreamlike-photoreal-2.0/resolve/main/dreamlike-photoreal-2.0.safetensors &

# install Koya_ss
git clone https://github.com/bmaltais/kohya_ss.git
python3 -m venv --system-site-packages $base_path/kohya_ss/venv && \
    source $base_path/kohya_ss/venv/bin/activate && \
    pip3 install torch torchvision torchaudio xformers && \
    pip3 install tensorflow[and-cuda] tensorrt && \
deactivate


pip3 install -U --no-cache-dir jupyterlab \
        jupyterlab_widgets \
        ipykernel \
        ipywidgets \
        gdown

chown -R ubuntu:ubuntu /home/ubuntu/
