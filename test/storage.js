const Storage = artifacts.require("Storage");

async function testRevert(revertTerm) {
  const storageInstance = await Storage.deployed();
  try{
    const storageRevert = await storageInstance[revertTerm].call();
  }
  catch{return;}
  assert.fail("The function should revert");
}

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Storage", function (/* accounts */) {
  it("Contract deploys", async function () {
    await Storage.deployed();
    return assert.isTrue(true);
  });
  it("Check if contracts revert.", () => testRevert("shouldRevert"));
});
