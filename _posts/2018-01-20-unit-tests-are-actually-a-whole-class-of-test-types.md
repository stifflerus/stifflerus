---
layout: post
title: >
    Unit Tests Are Actually a Whole Class of Test Types
---
Most developers and managers agree that unit testing improves code quality, but the term itself is ill-defined. The definition of a unit test can vary from company to company, team to team, and even developer to developer. The truth is that the "unit" part of unit testing only describes one aspect of a test: the size of the component under test. There exists a whole family test types that address small units of functionality, making them unit tests, but deviate considerably from what programmers in industry would consider a unit test.

# Many Dimensions of Test Types
There are at least four dimensions that characterize a software test. 'Unit' is a term that describes where a test falls only in one of these dimensions.
## Component Scale
The first dimension is the component scale dimension. This dimension describes the size of the component under test. At small scale, there are unit tests. Unit tests are concerned with small units of code, such as a single subroutine or module. At large scale, there are system tests. System tests are concerned with testing an entire system. In the middle there are integration tests. Integration tests are concerned with the interaction of the specific components that comprise a system. This is the only dimension to which the word 'unit' applies.
## System Knowledge
System knowledge is a dimension that describes how much is known about the internal workings of the component under test. This is usually described as black box versus "white box" testing. Black box tests assume no knowledge of the internal workings of the component under test. They test only the public interfaces of the component. On the other hand, white box tests do have knowledge of the internal workings of the component under test. An example of white box testing would be writing tests that test all branches of execution. In between white and black box is gray box testing, which testing with some knowledge of the internal workings of the component under test. Since very few software components in the real world have a complete specification of their behavior, most testing uses knowledge of the internal workings of the component to produce a post hoc specification. This is gray box testing. Unit tests can be white or black or any shade of gray.
## Execution Style
This is the most trivial dimension of the ones listed here. Execution style describes the way in which tests are run. There are automated tests, where testing is performed automatically by machine. There is also manual testing, where testing is performed by a human. The difference between the two is primarily a difference in speed. Most testing suites allows test to be run automatically, or manually by the developer.
## Completeness
Completeness is the final dimension. It describes level of detail a test has to confirm that the component under test conforms to the specification. A complete test suite tests all possible cases, confirming that the component satisfies it's specification. It is rare for a test suite to be complete, and only possible with simple components that have a complete specification. At the other extreme is bare minimum testing, in which only a few key cases are tested. These are usually the most typical cases, called happy paths. This type of testing is sometimes called smoke testing, named after the bare minimum test of an electrical circuit. The middle ground is having enough tests to cover edge cases, but not a complete test suite.

# There Are Middle Grounds in Every Dimension
Notice how every single dimension is actually a spectrum with many (sometimes literal) shades of gray between the two extremes. If we limit ourselves to consider each dimension to have two extremes and only one middle ground, there would be 81 possible types of tests. Of these, there are 27 distinct types of unit tests.

# Different Tests for Different Components
There is no best type of unit test. There are only best practices that describe what types of tests are typically the most useful. Best practices are not universal, however. Different types of tests should be considered for each component under test, and used when they are deemed to be the most useful. For example, unit testing a component that is highly database dependent is rarely useful without including the database. However, that would formally be considered an integration test. As mentioned above, test completeness is rarely achievable, but should be striven for whenever it is possible. Grey box testing may be useful for developers to test for correct operation of components, but externally facing components and libraries benefit much more greatly from black box tests.

# Unit Test Myths
* **Unit tests have to be automated** - Test automation only describes the execution style of a test, and does not preclude it from being a unit test. Unit tests can be run manually, although automated tests are arguably more useful. The point is that automation is not the defining feature of a unit test.
* **Unit tests have to be black box** - Unit tests can be written in black box or white box or gray box form.
* **Unit tests have to be white box** - See above.
* **Unit tests should test all cases** - While this is rarely possible, it only addresses the completeness dimension of testing. It does not preclude a test from being a unit test.
* **Unit tests should only test happy paths** - See above.
* **Unit tests cannot have dependencies** - This is generally given as a best practice to avoid accidentally writing integration tests. However, there are instances where multiple components together can be views as a single unit. An example would be a component that is tightly coupled to a database or persistent storage system. If two components are tightly coupled, and small in comparison to the scale of the overall system, they can be considered a single unit. Therefore, testing them together can still be considered unit testing.

# Final Thoughts
The "unit" part of unit testing only addresses one quality of the test. When you don't mean to refer to the entire set of 27 types of unit tests, you should tighten your definition of the types of tests you are looking for. For example: "automated, black box unit tests that cover all known corner cases."
