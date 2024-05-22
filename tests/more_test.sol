// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "hardhat/console.sol";
import "../contracts/storage.sol";

contract MoreTest {
    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        string[10] friends;
        Account account;
    }

    Person alice;
    Person bob;
    Person[] family;

    function testStorageKeyWord() public {
        alice.account.balance = 1;
        bob.account.balance = 0;

        Account storage accAlice = alice.account;
        bob.account = accAlice;
        Assert.equal(bob.account.balance, 1, "Should copy storage");
    }

    function testLinkingStorage() public {
        alice.account.balance = 0;

        Account storage accAlice = alice.account;
        accAlice.balance = 1;
        Assert.equal(alice.account.balance, 1, "Storage key word is a link");
    }

    function testLinkingStorageModification() public {
        Account storage accAlice = alice.account;
        alice.account = Account(2);
        accAlice.balance = 1;
        Assert.equal(alice.account.balance, 1, "Storage key word is a link");
    }

    function testTwoStorage() public {
        alice.age = 20;
        bob.age = 40;

        Person storage alicePath = alice;
        Person storage bobPath = bob;
        
        alicePath = bobPath;
        Assert.equal(alice.age, 20, "Should not copy");
        
        alicePath.age = 21;
        Assert.equal(alice.age, 20, "Alice Path is Bob");
        Assert.equal(bob.age, 21, "Alice Path is Bob");
    }

    function testTwoStorage2() public {
        alice.age = 20;
        bob.age = 40;

        Person storage alicePath = alice;
        
        alicePath = bob;
        Assert.equal(alice.age, 20, "Should not copy");
        
        alicePath.age = 21;
        Assert.equal(alice.age, 20, "Alice Path is Bob");
        Assert.equal(bob.age, 21, "Alice Path is Bob");
    }

    function testChangingStorage() public {
        alice.account.balance = 1;
        bob.account.balance = 2;

        Account storage aliceAccPath = alice.account;
        alice.account = bob.account;
        bob.account.balance = 3;
        
        Assert.equal(alice.account.balance, 2, "Should deep copy Bob");
        Assert.equal(aliceAccPath.balance, 2, "Should deep copy Bob");
    }

    function testStorageConcrete() public {
        // Does not compile

        // int storage aliceAgePath = alice.age;
    }

    function testSimpleDeepCopy() public {
        bob.age = 0;
        alice.age = 20;

        bob = alice;
        Assert.equal(bob.age, 20, "should deep copy");
    }
}
