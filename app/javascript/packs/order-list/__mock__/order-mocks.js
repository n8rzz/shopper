export const locationNameMock = 'Bergstrom Group';

export const orderMock = {
    created_at: '2019-07-27T02:41:50.554Z',
    id: 3,
    location_id: 5,
    shopping_date: '2018-09-29T00:00:00.000Z',
    status: 'complete',
    updated_at: '2019-07-27T02:41:50.554Z',
};

export const locationsMock = [
    {
        city: 'Elyria',
        created_at: '2019-07-27T02:41:50.022Z',
        id: 1,
        name: 'Dickinson and Sons',
        state: 'Yavin 4',
        updated_at: '2019-07-27T02:41:50.022Z',
    },
    {
        city: 'Gulltown',
        created_at: '2019-07-27T02:41:50.027Z',
        id: 2,
        name: 'Erdman-Abbott',
        state: 'Crait',
        updated_at: '2019-07-27T02:41:50.027Z',
    },
];

export const locationMapMock = {
    1: {
        city: 'Elyria',
        created_at: '2019-07-27T02:41:50.022Z',
        id: 1,
        name: 'Dickinson and Sons',
        state: 'Yavin 4',
        updated_at: '2019-07-27T02:41:50.022Z',
    },
    2: {
        city: 'Gulltown',
        created_at: '2019-07-27T02:41:50.027Z',
        id: 2,
        name: 'Erdman-Abbott',
        state: 'Crait',
        updated_at: '2019-07-27T02:41:50.027Z',
    },
};

export const completeItemsMock = [
    {
        created_at: '2019-07-27T02:41:50.579Z',
        id: 4,
        location_id: 1,
        shopping_date: '2018-12-03T00:00:00.000Z',
        status: 'complete',
        updated_at: '2019-07-27T02:41:50.579Z',
    },
    {
        created_at: '2019-07-27T02:41:50.595Z',
        id: 5,
        location_id: 2,
        shopping_date: '2020-05-24T00:00:00.000Z',
        status: 'complete',
        updated_at: '2019-07-27T02:41:50.595Z',
    },
];

export const pendingItemsMock = [
    {
        created_at: '2019-07-27T02:41:50.579Z',
        id: 3,
        location_id: 2,
        shopping_date: '2018-12-03T00:00:00.000Z',
        status: 'pending',
        updated_at: '2019-07-27T02:41:50.579Z',
    },
];

export const ordersByConcernMock = [
    {
        items: pendingItemsMock,
        name: 'Pending',
        renderer: 'card',
    },
    {
        items: [],
        name: 'Active',
        renderer: 'card',
    },
    {
        items: completeItemsMock,
        name: 'Complete',
        renderer: 'simple',
    },
];
