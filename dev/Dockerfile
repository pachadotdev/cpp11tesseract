# Use Fedora 40 as the base image
FROM fedora:40

# Install OpenSSH server and other necessary packages
RUN dnf install -y openssh-server passwd sudo && \
    dnf clean all

# Enable SSH service
RUN systemctl enable sshd

# Create the 'sudo' group and a user 'dockeruser' with a password 'password'
RUN groupadd sudo && \
    useradd -rm -d /home/dockeruser -s /bin/bash -g root -G sudo -u 1000 dockeruser && \
    echo 'dockeruser:password' | chpasswd

# Add dockeruser to sudoers
RUN echo 'dockeruser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set up SSH key generation for root
RUN ssh-keygen -A

# Expose port 22 for SSH access
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
