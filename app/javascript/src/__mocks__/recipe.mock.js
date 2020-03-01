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
