#### Just a simple BASH setup script to set packages and ufw / ssh.
##### kittens.sh
[![Build Status](https://travis-ci.org/archae0pteryx/kittens.svg?branch=master)](https://travis-ci.org/archae0pteryx/kittens)

1. Select your username in the vars at top of kittens.sh
2. put your pubic key into the keys folder (I have provided default ones if you need. obviously don't use in production)
3. You can exclude whole chunks of the package install by commenting out the appropriate call in the "Rock" function.
2. You can either be prompted to to enter one at execution (recommended) or you can supply one ahead of time. The current version only supports prompt* See TODO:
2. Select your public key.
3. Set package manager (apt/dnf/yum/etc)*
3. Run Script


TODO*
- Pass password ahead of time.
- Other pkg mgmt support
- pass to python
