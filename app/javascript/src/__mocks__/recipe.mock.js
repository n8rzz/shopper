/* eslint-disable max-len */
export const recipeIngredientMock = {
    item_id: null,
    name: 'Basil',
    qty_unit: 'Monkeys',
    qty_value: '10',
    recipe_id: 1,
};

export const recipeInstructionMock = {
    recipe_id: 1,
    sort_order: 0,
    text: 'Migas normcore heirloom pug jean shorts gentrify irony. Typewriter flexitarian synth dreamcatcher tilde swag salvia. Flannel paleo taxidermy viral muggle magic. Banjo roof cleanse semiotics.'
};

export const recipeMock = {
    id: 1,
    name: 'Mushroom Risotto',
    description: 'Two buttermilk waffles, topped with whipped cream and maple syrup, a side of two eggs served any style, and your choice of smoked bacon or smoked ham.',
    prep_time: 14,
    cook_time: 18,
    yield_value: 28,
    yield_unit: 'servings',
    ownable_type: 'Group',
    ownable_id: 1,
    created_at: '2020-03-01T04:13:06.254Z',
    updated_at: '2020-03-01T04:13:06.254Z',
    assembly_id: null,
    recipe_ingredients: [recipeIngredientMock],
    recipe_instructions: [recipeInstructionMock],
};

export const recipeWithAssemblyMock = {
    id: 2,
    name: 'Mushroom Risotto',
    description: 'Two buttermilk waffles, topped with whipped cream and maple syrup, a side of two eggs served any style, and your choice of smoked bacon or smoked ham.',
    prep_time: 14,
    cook_time: 18,
    yield_value: 28,
    yield_unit: 'servings',
    ownable_type: 'Group',
    ownable_id: 1,
    created_at: '2020-03-01T04:13:06.254Z',
    updated_at: '2020-03-01T04:13:06.254Z',
    assembly_id: 1,
};

export const recipeListMock = [
    recipeMock,
    recipeWithAssemblyMock,
];
