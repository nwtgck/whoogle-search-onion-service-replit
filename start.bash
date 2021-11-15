#! /bin/bash -eu

mkdir -p /home/runner/psuedo_root/var/log/tor/
mkdir -p /home/runner/psuedo_root/var/lib/tor/hidden_service/
chmod 700 /home/runner/psuedo_root/var/lib/tor/hidden_service/

# NOTE: public_key and hostname are automatically generated from the private key
echo "${HS_ED25519_SECRET_KEY_BASE64}" | base64 -d > /home/runner/psuedo_root/var/lib/tor/hidden_service/hs_ed25519_secret_key

unset HS_ED25519_SECRET_KEY_BASE64;

trap 'kill $(jobs -p)' EXIT

# e.g. /nix/store/nki9ywqzbvz68vr75kn2r7g1q84f5agy-python3-3.9.6
python3_root=$(dirname $(dirname $(which python3)))

# Without chmod permission denied
chmod +w $python3_root/lib/python3.9/site-packages/
# Without chmod permission denied
chmod +w $python3_root/bin/
pip3 install -r requirements.txt

whoogle-search --host=0.0.0.0 &
tor -f torrc &
wait
