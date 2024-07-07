# EC2-StableDiffusion-Template
This repository prepares an EC2 Instance (usually spot instance) for training and stable diffusion using. All services are locally bonded and the user is expected to ssh tunnel to connect to any of them making it secure from outside unintended use.

Just clone this repository on the newly spawned G4DN, G5 or P3 Instance and run setup.sh

# Default ports:
| Service | Listening | 
| ------- | --------- |
| Jupyter Notebook | 8888 |
| Kohya_SS | 3010 |

Suggested SSH:
ssh -L 8888:127.0.0.1:8888 -L 3010:127.0.0.1:3010 -i mysecretkey.pem ubuntu@instanceAddress

# Control the services:

sudo systemctl start kohya-ss.service
sudo systemctl start jupyterlab-ubuntu.service
