export const assemblyMock = {
    id: 1,
    name: 'Souvlaki',
    created_at: '2019-07-29T22:49:47.431Z',
    updated_at: '2019-07-29T22:49:47.431Z',
};

export const assemblyListMock = [
    {
        ...assemblyMock,
    },
    {
        id: 2,
        name: 'Chilli con Carne',
        created_at: '2019-07-29T22:49:47.519Z',
        updated_at: '2019-07-29T22:49:47.519Z',
    },
];

export const assemblyMapMock = {
    1: assemblyListMock[0],
    2: assemblyListMock[1],
};
