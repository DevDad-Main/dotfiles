import { it, expect, describe, vi } from "vitest";
import { generateReportData, storeData } from "./data";

describe("generateReportData()", () => {
  it("should execute logFn if provided", () => {
    //#region NOTE: First Spy function, this .fn() creates an empty function which keeps track of any function executions of that function(any calls to that function), keeps track of the arguments that were provided with those calls
    //#endregion
    const logger = vi.fn();

    generateReportData(logger);

    expect(logger).toBeCalled();
  });
});

describe("storeData()", () => {});
