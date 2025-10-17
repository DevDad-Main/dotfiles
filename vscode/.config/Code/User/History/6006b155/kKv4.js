import { it, expect, vi } from "vitest";
import writeData from "./io";

//#region NOTE: Here, we are mocking the fs module. This means that we can replace the functionality of all the modules functions with empty spies. In this case, we are replacing the writeFile function with a mock function that simply returns undefined.
//#endregion
vi.mock("fs");

//#region NOTE: Here, we have the problem that I don't wanna execute the original writeFile function or method. Instead, we only wanna find out if it was called, but it shouldn't do its job of writing to the file system. It should do that during production, but not when we run our tests. This also sounds like the perfect use case and scenario for a spy, right?.

//NOTE: The only issue is with the spy is that we were passing in an empty function for the spy to check if it was called and its arguments

//NOTE: But this is where mocks come into play. With mocks we can easily replace functionalities that are defined in modules no matter if we own them or not.

//#endregion
it("should execute the writeFile method", () => {
  const testData = "test";
  const testFileName = "test.txt";

  //NOTE: Now this should no longer write to the file system as we are mocking the writeFile function
  return expect(writeData(testData, testFileName)).resolves.toBeUndefined();
});
