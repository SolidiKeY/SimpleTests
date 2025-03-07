// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract SimpleMemory {

    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        string[10] friends;
        Account account;
    }

    function testMemory() pure public {
        Person memory alice;
        Person memory bob;

        alice.account.balance = 10;
        bob.account.balance = 20;
        Account memory acc = bob.account;

        alice.account = bob.account;
        assert(acc.balance == 20);

        alice.account.balance = 30;
        assert(alice.account.balance == 30);
        assert(bob.account.balance == 30);
    }

    function testDefault() pure public {
        Person memory alice;
        Person memory bob;
        assert(alice.account.balance == 0);

        bob.account.balance = 10;
        assert(alice.account.balance == 0);
    }

    function testDefault2() pure public {
        Person memory alice;
        Person memory bob;
        assert(alice.account.balance == 0);

        bob.account.balance = 10;
        bob.account = alice.account;
        assert(bob.account.balance == 0);
    }

    function testMemoryComplex() pure public {
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

    function testShallowStruct() pure public {
        Person memory eve;
        Person memory carol;

        carol = eve;
        eve.age = 20;

        int v1 = carol.age;
        assert(v1 == 20);
    }

    function testArray() pure public {
        Person[] memory friends = new Person[](10);
        friends[1] = friends[0];
        friends[0].age = 20;

        int friendAge1 = friends[1].age;
        assert(friendAge1 == 20);
    }

    function testDynamicVec() pure public {
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

    function testDynamicMatrix() pure public {
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

    function testMatrixRowCopy() pure public {
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

