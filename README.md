Example of command to verify:

```bash
solc --model-checker-engine all mc/evaluation_order.sol
```

```bash
/solidity/build/solc/solc-verify.py --solver z3 mc/simple_not_working_memory.sol
```

Solidifier commands

```bash
docker build -t stest .devcontainer
docker run -v .:/exs -it stest Solidifier /exs/Solidifier/Simple.sol Simple testMatrixDefaultValue
```