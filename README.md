# MBS
Sample of a mortgage backed security on a blockchain in Solidiy

Create environment variables:
`chain_dir=$HOME/.eris/chains/simplechain`
`chain_dir_this=$chain_dir/simplechain_full_000`

Make files required for chain:
`eris chains make --account-types=Root:2,Full:1 simplechain`

Create instance of chain:
`eris chains new simplechain --dir $chain_dir_this`

Extract newly created address which will be used as default account for deploying contracts:
`addr=$(cat $chain_dir/addresses.csv | grep simplechain_full_000 | cut -d ',' -f 1)`

Run epm:
`cd contracts`
`eris pkgs do --chain simplechain --address $addr`
