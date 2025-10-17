import { it, expect, describe } from "vitest";
import { HttpError, ValidationError } from "./errors";

describe("ValidationError", () => {
  it("should create an instance with a message", () => {
    const message = "Invalid input";
    const error = new ValidationError(message);

    expect(error.message);
    expect(error).toBeInstanceOf(ValidationError);
    expect(error.message).toBe(message);
  });

  it("should return an error if message is not of type string", () => {
    const message = "an error message";
    const error = new ValidationError(message);

    expect(error.message).toBeTypeOf("string");
  });

  it("should return an error if the message is an empty string", () => {
    const message = "";
    const error = new ValidationError(message);

    expect(error.message).toBe("");
  });
});
