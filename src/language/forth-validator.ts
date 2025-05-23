import type { ValidationAcceptor, ValidationChecks } from 'langium';
import type { ForthAstType, Person } from './generated/ast.js';
import type { ForthServices } from './forth-module.js';

/**
 * Register custom validation checks.
 */
export function registerValidationChecks(services: ForthServices) {
    const registry = services.validation.ValidationRegistry;
    const validator = services.validation.ForthValidator;
    const checks: ValidationChecks<ForthAstType> = {
        Person: validator.checkPersonStartsWithCapital
    };
    registry.register(checks, validator);
}

/**
 * Implementation of custom validations.
 */
export class ForthValidator {

    checkPersonStartsWithCapital(person: Person, accept: ValidationAcceptor): void {
        if (person.name) {
            const firstChar = person.name.substring(0, 1);
            if (firstChar.toUpperCase() !== firstChar) {
                accept('warning', 'Person name should start with a capital.', { node: person, property: 'name' });
            }
        }
    }

}
