import { it, expect, describe } from "vitest";
import { HttpError, ValidationError } from "./errors";

describe("ValidationError", () => {
  it("should create an instance with a message", () => {
    const message = "Invalid input";
    const error = new ValidationError(message);

    expect(error).toBeInstanceOf(ValidationError);
    expect(error.message).toBe(message);
  });

  it("should return an error if no message is provided", () => {
    const error = new ValidationError();

    expect(error).toBeInstanceOf(ValidationError);
    expect(error.message).toBe("Invalid input data");
  });
});
