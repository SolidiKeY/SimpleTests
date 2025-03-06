// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SimpleStorage {
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
    Person ana;
    Person carol;
    Person[] family;

    int[] vInt1;
    int[] vInt2;

    mapping (address => uint) public balances;

    function testStorage() public {
        int aliceAgeBefore = alice.age;
        assert(aliceAgeBefore == 0);
        family.push(alice);
        alice.age = 20;
        int aliceAge = family[0].age;
        assert(aliceAge == 0);

        Person memory bob;
        bob.age = 40;
        family.push(bob);
        bob.age = 41;
        int bobAge = family[1].age;
        assert(bobAge == 40);
    }
}

