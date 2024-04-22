
%%% Defining the moves of Rubik's cube. %%%

% Move up face clockwise up(+Cube, -NewCube), anti-clockwise up(-NewCube, +Cube)
up(
    cube(
        C1, C2, C3, C4, C5, C6, C7, C8, C9,
        C11, C12, C13, C14, C15, C16, C17, C18, C19,
        C21, C22, C23, C24, C25, C26, C27, C28, C29,
        C31, C32, C33, C34, C35, C36, C37, C38, C39,
        C41, C42, C43, C44, C45, C46, C47, C48, C49,
        C51, C52, C53, C54, C55, C56, C57, C58, C59
    ),
    cube(
        C7, C4, C1, C8, C5, C2, C9, C6, C3,
        C21, C22, C23, C14, C15, C16, C17, C18, C19,
        C31, C32, C33, C24, C25, C26, C27, C28, C29,
        C41, C42, C43, C34, C35, C36, C37, C38, C39,
        C11, C12, C13, C44, C45, C46, C47, C48, C49,
        C51, C52, C53, C54, C55, C56, C57, C58, C59
    )
).

% Move front face clockwise front(+Cube, -NewCube), anti-clockwise front(-NewCube, +Cube)
front(
    cube(
        C1, C2, C3, C4, C5, C6, C7, C8, C9,
        C11, C12, C13, C14, C15, C16, C17, C18, C19,
        C21, C22, C23, C24, C25, C26, C27, C28, C29,
        C31, C32, C33, C34, C35, C36, C37, C38, C39,
        C41, C42, C43, C44, C45, C46, C47, C48, C49,
        C51, C52, C53, C54, C55, C56, C57, C58, C59
    ),
    cube(
        C1, C2, C3, C4, C5, C6, C19, C16, C13, 
        C11, C12, C51, C14, C15, C52, C17, C18, C53, 
        C27, C24, C21, C28, C25, C22, C29, C26, C23,  
        C7, C32, C33, C8, C35, C36, C9, C38, C39, 
        C41, C42, C43, C44, C45, C46, C47, C48, C49,
        C37, C34, C31, C54, C55, C56, C57, C58, C59
    )
).

% Move right face clockwise right(+Cube, -NewCube), anti-clockwise right(-NewCube, +Cube)
right(
    cube(
        C1, C2, C3, C4, C5, C6, C7, C8, C9,
        C11, C12, C13, C14, C15, C16, C17, C18, C19,
        C21, C22, C23, C24, C25, C26, C27, C28, C29,
        C31, C32, C33, C34, C35, C36, C37, C38, C39,
        C41, C42, C43, C44, C45, C46, C47, C48, C49,
        C51, C52, C53, C54, C55, C56, C57, C58, C59
    ),
    cube(
        C1, C2, C23, C4, C5, C26, C7, C8, C29, 
        C11, C12, C13, C14, C15, C16, C17, C18, C19,
        C21, C22, C53, C24, C25, C56, C27, C28, C59, 
        C37, C34, C31, C38, C35, C32, C39, C36, C33, 
        C9, C42, C43, C6, C45, C46, C3, C48, C49, 
        C51, C52, C47, C54, C55, C44, C57, C58, C41
    )
).

% Move back face clockwise back(+Cube, -NewCube), anti-clockwise back(-NewCube, +Cube)
back(
    cube(
        C1, C2, C3, C4, C5, C6, C7, C8, C9,
        C11, C12, C13, C14, C15, C16, C17, C18, C19,
        C21, C22, C23, C24, C25, C26, C27, C28, C29,
        C31, C32, C33, C34, C35, C36, C37, C38, C39,
        C41, C42, C43, C44, C45, C46, C47, C48, C49,
        C51, C52, C53, C54, C55, C56, C57, C58, C59
    ),
    % cube( % prime
    %     C17, C14, C11, C4, C5, C6, C7, C8, C9, 
    %     C57, C12, C13, C58, C15, C16, C59, C18, C19, 
    %     C21, C22, C23, C24, C25, C26, C27, C28, C29,
    %     C31, C32, C1, C34, C35, C2, C37, C38, C3,
    %     C43, C46, C49, C42, C45, C48, C41, C44, C47,
    %     C51, C52, C53, C54, C55, C56, C39, C36, C33
    % )
    cube(   %correct
        C33, C36, C39, C4, C5, C6, C7, C8, C9, 
        C3, C12, C13, C2, C15, C16, C1, C18, C19, 
        C21, C22, C23, C24, C25, C26, C27, C28, C29,
        C31, C32, C59, C34, C35, C58, C37, C38, C57,
        C47, C44, C41, C48, C45, C42, C49, C46, C43,
        C51, C52, C53, C54, C55, C56, C11, C14, C17
    )
).

% Move left face clockwise left(+Cube, -NewCube), anti-clockwise left(-NewCube, +Cube)
left(
    cube(
        C1, C2, C3, C4, C5, C6, C7, C8, C9,
        C11, C12, C13, C14, C15, C16, C17, C18, C19,
        C21, C22, C23, C24, C25, C26, C27, C28, C29,
        C31, C32, C33, C34, C35, C36, C37, C38, C39,
        C41, C42, C43, C44, C45, C46, C47, C48, C49,
        C51, C52, C53, C54, C55, C56, C57, C58, C59
    ),
    cube(
        C49, C2, C3, C46, C5, C6, C43, C8, C9,
        C17, C14, C11, C18, C15, C12, C19, C16, C13,
        C1, C22, C23, C4, C25, C26, C7, C28, C29,
        C31, C32, C33, C34, C35, C36, C37, C38, C39,
        C41, C42, C57, C44, C45, C54, C47, C48, C51,
        C21, C52, C53, C24, C55, C56, C27, C58, C59
    )
).

% Move down face clockwise down(+Cube, -NewCube), anti-clockwise down(-NewCube, +Cube)
down(
    cube(
        C1, C2, C3, C4, C5, C6, C7, C8, C9,
        C11, C12, C13, C14, C15, C16, C17, C18, C19,
        C21, C22, C23, C24, C25, C26, C27, C28, C29,
        C31, C32, C33, C34, C35, C36, C37, C38, C39,
        C41, C42, C43, C44, C45, C46, C47, C48, C49,
        C51, C52, C53, C54, C55, C56, C57, C58, C59
    ),
    % cube( % prime
    %     C1, C2, C3, C4, C5, C6, C7, C8, C9,
    %     C11, C12, C13, C14, C15, C16, C27, C28, C29,
    %     C21, C22, C23, C24, C25, C26, C37, C38, C39,
    %     C31, C32, C33, C34, C35, C36, C47, C48, C49,
    %     C41, C42, C43, C44, C45, C46, C17, C18, C19,
    %     C53, C56, C59, C52, C55, C58, C51, C54, C57
    % )
    cube(   % correct
        C1, C2, C3, C4, C5, C6, C7, C8, C9,
        C11, C12, C13, C14, C15, C16, C47, C48, C49,
        C21, C22, C23, C24, C25, C26, C17, C18, C19,
        C31, C32, C33, C34, C35, C36, C27, C28, C29,
        C41, C42, C43, C44, C45, C46, C37, C38, C39,
        C57, C54, C51, C58, C55, C52, C59, C56, C53
    )
).






% % Move down face clockwise
% down(
%     cube(
%         C1, C2, C3, C4, C5, C6, C7, C8, C9,
%         C11, C12, C13, C14, C15, C16, C17, C18, C19,
%         C21, C22, C23, C24, C25, C26, C27, C28, C29,
%         C31, C32, C33, C34, C35, C36, C37, C38, C39,
%         C41, C42, C43, C44, C45, C46, C47, C48, C49,
%         C51, C52, C53, C54, C55, C56, C57, C58, C59
%     ),
%     cube(
%         C7, C4, C1, C8, C5, C2, C9, C6, C3,
%         C11, C12, C13, C14, C15, C16, C27, C28, C29,
%         C21, C22, C23, C24, C25, C26, C37, C38, C39,
%         C31, C32, C33, C34, C35, C36, C47, C48, C49,
%         C41, C42, C43, C44, C45, C46, C17, C18, C19,
%         C51, C52, C53, C54, C55, C56, C57, C58, C59
%     )
% ).

% % Move down face anti-clockwise
% down_prime(
%     cube(
%         C1, C2, C3, C4, C5, C6, C7, C8, C9,
%         C11, C12, C13, C14, C15, C16, C17, C18, C19,
%         C21, C22, C23, C24, C25, C26, C27, C28, C29,
%         C31, C32, C33, C34, C35, C36, C37, C38, C39,
%         C41, C42, C43, C44, C45, C46, C47, C48, C49,
%         C51, C52, C53, C54, C55, C56, C57, C58, C59
%     ),
%     cube(
%         C3, C6, C9, C2, C5, C8, C1, C4, C7,
%         C11, C12, C13, C14, C15, C16, C47, C48, C49,
%         C21, C22, C23, C24, C25, C26, C17, C18, C19,
%         C31, C32, C33, C34, C35, C36, C27, C28, C29,
%         C41, C42, C43, C44, C45, C46, C37, C38, C39,
%         C51, C52, C53, C54, C55, C56, C57, C58, C59
%     )
% ).

% % Move front face clockwise
% front(
%     cube(
%         C1, C2, C3, C4, C5, C6, C7, C8, C9,
%         C11, C12, C13, C14, C15, C16, C17, C18, C19,
%         C21, C22, C23, C24, C25, C26, C27, C28, C29,
%         C31, C32, C33, C34, C35, C36, C37, C38, C39,
%         C41, C42, C43, C44, C45, C46, C47, C48, C49,
%         C51, C52, C53, C54, C55, C56, C57, C58, C59
%     ),
%     cube(
%         C41, C44, C47, C4, C5, C6, C7, C8, C9,
%         C17, C14, C11, C18, C15, C12, C19, C16, C13,
%         C21, C22, C1, C24, C25, C2, C27, C28, C3,
%         C31, C32, C33, C34, C35, C36, C37, C38, C39,
%         C57, C42, C43, C58, C45, C46, C59, C48, C49,
%         C51, C52, C53, C54, C55, C56, C29, C26, C23
%     )
% ).

% % Move front face anti-clockwise
% front_prime(
%     cube(
%         C1, C2, C3, C4, C5, C6, C7, C8, C9,
%         C11, C12, C13, C14, C15, C16, C17, C18, C19,
%         C21, C22, C23, C24, C25, C26, C27, C28, C29,
%         C31, C32, C33, C34, C35, C36, C37, C38, C39,
%         C41, C42, C43, C44, C45, C46, C47, C48, C49,
%         C51, C52, C53, C54, C55, C56, C57, C58, C59
%     ),
%     cube(
%         C23, C26, C29, C4, C5, C6, C7, C8, C9,
%         C13, C16, C19, C12, C15, C18, C11, C14, C17,
%         C21, C22, C59, C24, C25, C58, C27, C28, C57,
%         C31, C32, C33, C34, C35, C36, C37, C38, C39,
%         C3, C42, C43, C2, C45, C46, C1, C48, C49,
%         C51, C52, C53, C54, C55, C56, C41, C44, C47
%     )
% ).

% % Move left face clockwise
% left(
%     cube(
%         C1, C2, C3, C4, C5, C6, C7, C8, C9,
%         C11, C12, C13, C14, C15, C16, C17, C18, C19,
%         C21, C22, C23, C24, C25, C26, C27, C28, C29,
%         C31, C32, C33, C34, C35, C36, C37, C38, C39,
%         C41, C42, C43, C44, C45, C46, C47, C48, C49,
%         C51, C52, C53, C54, C55, C56, C57, C58, C59
%     ),
%     cube(
%         C11, C2, C3, C14, C5, C6, C17, C8, C9,
%         C51, C12, C13, C54, C15, C16, C57, C18, C19,
%         C27, C24, C21, C28, C25, C22, C29, C26, C23,
%         C31, C32, C7, C34, C35, C4, C37, C38, C1,
%     )
% ).
