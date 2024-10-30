const Storage = artifacts.require("Storage");

function testRevert(revertTerm) {
  return async () => {
    const storageInstance = await Storage.deployed();
    const storageRevert = storageInstance[revertTerm];
    try{
      await storageRevert.call();
    }
    catch{return;}
    assert.fail("The function should revert");
  }
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
});
