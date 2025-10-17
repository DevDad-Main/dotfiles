import {it, expect, describe} from 'vitest';
import { HttpError, ValidationError } from './errors';


describe("ValidationError", () => {
  it("should create an instance with message and details", () => {
    const message = "Invalid input";
    const details = { field: "username", issue: "required" };
    const error = new ValidationError(message, details);

    expect(error).toBeInstanceOf(ValidationError);
    expect(error.message).toBe(message);
    expect(error.details).toBe(details);
    expect(error.name).toBe("ValidationError");
  });
});
