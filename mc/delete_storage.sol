// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DeleteStorageTest {
    struct Account {
        int balance;
    }

    struct Person {
        int age;
        bool isMale;
        string[10] friends;
        Account account;
    }

    Person[] people;
    int[] v;
    Person p;
    int vStorage;

    function testStoragePath() public {
        // int storage vStorageP = vStorage;
        // Code does not work
    }

    function testDeleteArrayStorage() public {
        v.push(1);
        v.push(2);

        delete v[1];
        delete v;

        assert(v.length == 0);
    }

    function testDeletePushArray() public {
        v.push(1);

        delete v;

        v.push();

        assert(v[0] == 0);
    }

    function testDeleteStructArrayStorage() public {
        p.friends[0] = "alice";

        delete p.friends;
        assert(p.friends.length == 10);
    }

    function testDeletePush() public {
        v.push(1);
        v.pop();
        v.push();

        // assert(v[0] == 0);
    }    
    
    uint[][] s;

    function testRemoveMatrix() public {
        delete s;

        s.push();
        uint[] storage ptr = s[0];
        ptr.push(41);
        s.pop();

        assert(ptr.length == 0);
        ptr.push(42);

        assert(ptr[0] == 42);

        // st = store(store(st, s, empty), s.at(0).at(0), 42)

        s.push();
        // st = store(store(store(st, s, empty), s.at(0).at(0), 42), s.length, 1) 

        // assert(s[0][0] == 42);
    }

    function testDeleteMatrix() public {
        delete s;

        s.push();
        s.push();
        uint[] storage ptr = s[0];
        delete s;
        ptr.push(42);
        s.push();
        assert(s[0][0] == 42);
    }

    // function testRemoveMatrixNoPath() public {
    //     delete s;

    //     s.push();
    //     s[0].push(41);
    //     s.pop();
    //     // s[0].push(42);
    //     // Code does not work because it reverts
    // }

    // function testAddToArray() public {
    //     delete v;

    //     v.push(0x41);
    //     v.pop();
    //     // int u = v[0];
    //     // Code does not work because index out of bound
    // }

    // function testRemoveMatrixNoPointer() public {
    //     delete s;

    //     s.push();
    //     s[0].push(42);
    //     s.pop();
    //     s.push();

    //     Assert.equal(s[0].length, 0, "array is erased");
    // }
    
    // function testRemoveMatrixPushBefore() public {
    //     delete s;

    //     s.push();
    //     uint[] storage ptr = s[0];
    //     ptr.push(0x42);
    //     s.pop();
    //     s.push();

    //     Assert.equal(s[0].length, 0, "array is erased");
    //     Assert.equal(ptr.length, 0, "ptr should be deleted");
    // }

    // uint[][][] sm;

    // function testBigMatrix() public {
    //     delete sm;

    //     sm.push();
    //     sm[0].push();
    //     sm[0][0].push();

    //     uint[] storage smP = sm[0][0];
    //     sm.pop();
    //     smP.push(2);

    //     sm.push();
    //     sm[0].push();

    //     Assert.equal(sm[0][0][0], 2, "it is the same value");
    // }

    // function testBigMatrix2() public {
    //     delete sm;

    //     sm.push();
    //     sm[0].push();
    //     sm[0][0].push(1);

    //     uint[] storage smP = sm[0][0];
    //     sm.pop();
    //     Assert.equal(smP.length, 0, "Deleted everything");
    //     smP.push(2);

    //     sm.push();
    //     sm[0].push();

    //     Assert.equal(sm[0][0][0], 2, "it is the same value");
    // }
}
