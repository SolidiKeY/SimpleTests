// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Simple {
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

    function testMemory() public {
        Person memory alice;
        Person memory bob;

        alice.account.balance = 10;
        bob.account.balance = 20;
        Account memory acc = bob.account;

        alice.account = bob.account;
        assert(acc.balance == 20);

        acc.balance = 30;
        assert(alice.account.balance == 30);
        assert(bob.account.balance == 30);
    }

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

    function testCanCompare() public {
        // bool aliceEqAna = alice == ana;
        // Can not compare structure in storage

        // bool sameArray = vInt1 == vInt2;
        // Can not compare arrays in storage

        Person memory pMemory1;
        Person memory pMemory2;

        // bool sameMemory = pMemory1 == pMemory2;
        // Can not compare structures in memory

        int[] memory v1;
        int[] memory v2;

        // bool v1EqV2 = v1 == v2;
        // Can not compare arrays in memory
    }

    function testArray() public {
        Person[] memory friends = new Person[](10);
        friends[1] = friends[0];
        friends[0].age = 20;

        int friendAge1 = friends[1].age;
        assert(friendAge1 == 20);
    }

    function testShallowStruct() public {
        Person memory eve;
        Person memory caroll;

        caroll = eve;
        eve.age = 20;

        int v1 = carol.age;
        assert(v1 == 20);
    }

    int[] public ages;

    function testDynamicVec() public {
        int[] memory yearsVec;
        int[] memory numbers;

        numbers = yearsVec;
        yearsVec = new int[](10);

        uint numbersSize = numbers.length;
        assert(numbersSize == 0);

        numbers = yearsVec;
        numbersSize = numbers.length;
        assert(numbersSize == 10);

        yearsVec[0] = 1;
        int numbers0 = numbers[0];
        assert(numbers0 == 1);
    }

    function testDynamicMatrix() public {
        int[][] memory matrix1;
        int[][] memory matrix2;

        matrix1 = new int[][](10);
        matrix2 = matrix1;

        uint v = matrix1.length;
        assert(v == 10);

        matrix2[0] = new int[](2);
        matrix2[0][1] = 3;

        uint s10 = matrix1[0].length;
        assert(s10 == 2);

        int v101 = matrix1[0][1];
        assert(v101 == 3);
    }

    function testMatrixRowCopy() public {
        int[][5] memory matrix;

        matrix[0] = new int[](10);
        matrix[1] = matrix[0];

        uint s11 = matrix[1].length;
        assert(s11 == 10);

        matrix[0][0] = 2;
        int m10 = matrix[1][0];
        assert(m10 == 2);
    }
}

